---
title: "Molecule for Networking Services Ansible Automation Development"
author: "Rick Holbert"
---
### Overview

To develop and test Ansible playbooks and roles for networking services using Molecule:

1. **Set Up a Python Virtual Environment**:
   ```bash
   python3 -m venv molecule-venv
   source molecule-venv/bin/activate
   python3 -m pip install --upgrade pip
   python3 -m pip install ansible-dev-tools molecule-goss podman ansible-lint ansible-later yamllint
   ```

2. **Create a Project Structure**:
   ```bash
   mkdir ansible-networking
   cd ansible-networking
   mkdir playbooks roles
   ```

3. **Initialize a Molecule Scenario**:
   For a playbook, initialize a scenario:
   ```bash
   molecule init scenario -d podman --verifier-name goss
   ```
   For a role (e.g., `network_config`), initialize within the `roles/` directory:
   ```bash
   cd roles
   molecule init role -d podman --verifier-name goss network_config
   cd ..
   ```

4. **Configure `molecule.yml`**:
   Update `molecule/default/molecule.yml` to use a network device simulator (e.g., Cumulus VX for Linux-based switches) or a containerized network service (e.g., FRR for routing). Example for Cumulus VX:
   ```yaml
   ---
   dependency:
     name: galaxy
   driver:
     name: podman
   platforms:
     - name: cumulus-vx
       image: cumulusnetworks/cumulus-vx:4.4.0
       privileged: true
       network_mode: bridge
       command: /sbin/init
       pre_build_image: true
   provisioner:
     name: ansible
     playbooks:
       converge: ../playbooks/network_playbook.yml
     connection_options:
       ansible_connection: ansible.netcommon.network_cli
       ansible_network_os: cumulusnetworks.cumulus.cumulus
       ansible_user: cumulus
       ansible_password: CumulusLinux!
       ansible_become: yes
       ansible_become_method: sudo
     lint:
       name: ansible-lint
   verifier:
     name: goss
     enabled: true
   ```
   - **Key Settings**:
     - `platforms`: Uses Cumulus VX, a Linux-based network OS, for testing.
     - `provisioner.playbooks.converge`: Points to your playbook (e.g., `../playbooks/network_playbook.yml`).
     - `provisioner.connection_options`: Configures Ansible for network devices using `network_cli`.
     - `provisioner.lint`: Uses `ansible-lint`, avoiding the deprecated `lint` key.
     - `verifier`: Sets Goss for configuration validation.

5. **Create the Playbook**:
   Create `playbooks/network_playbook.yml` to configure a networking service (e.g., VLANs on a Cumulus switch):
   ```yaml
   ---
   - name: Configure Network Switch
     hosts: all
     become: true
     tasks:
       - name: Configure VLAN 10
         ansible.netcommon.cli_config:
           config: |
             vlan 10
               name TEST_VLAN
         register: result
       - name: Ensure OSPF is enabled
         ansible.netcommon.cli_config:
           config: |
             router ospf
               ospf router-id 1.1.1.1
               network 192.168.1.0/24 area 0
   ```

6. **Create the Role (Optional)**:
   If using a role, edit `roles/network_config/tasks/main.yml`:
   ```yaml
   ---
   - name: Configure VLAN 10
     ansible.netcommon.cli_config:
       config: |
         vlan 10
           name TEST_VLAN
   - name: Enable OSPF
     ansible.netcommon.cli_config:
       config: |
         router ospf
           ospf router-id 1.1.1.1
           network 192.168.1.0/24 area 0
   ```
   Update `playbooks/network_playbook.yml` to use the role:
   ```yaml
   ---
   - name: Apply Network Role
     hosts: all
     become: true
     roles:
       - network_config
   ```

7. **Write Goss Tests**:
   Create `molecule/default/tests/test_default.yml` to verify network configurations:
   ```yaml
   ---
   command:
     ip link show vlan10:
       exit-status: 0
       stdout:
         - "vlan10.*vlan.*id 10"
     ospfctl show ospf:
       exit-status: 0
       stdout:
         - "Router ID: 1.1.1.1"
   file:
     /etc/frr/frr.conf:
       exists: true
       contains:
         - "router ospf"
         - "network 192.168.1.0/24 area 0"
   ```
   - Verifies VLAN 10 exists, OSPF is configured, and the FRR configuration file is correct.

8. **Run Molecule Tests**:
   ```bash
   molecule test
   ```
   - Runs linting (`ansible-lint`, `yamllint` if configured), creates the Podman container, applies the playbook/role, verifies with Goss, and cleans up.

9. **Deactivate Virtual Environment**:
   ```bash
   deactivate
   ```

**Notes**:
- **Network Simulators**: Use Cumulus VX, FRR, or Arista vEOS for testing. For Cisco, consider GNS3 or VIRL with a license.
- **Connection**: Use `ansible.netcommon.network_cli` or `ansible.netcommon.netconf` for network devices.
- **Goss**: Limited to Linux-based network OSes (e.g., Cumulus VX). For proprietary devices, use `ansible.netcommon.cli_command` for verification or custom scripts.

---

### Comprehensive Guide to Developing Ansible Playbooks and Roles for Networking Services with Molecule

This guide expands on the direct answer, providing a detailed workflow for developing and testing Ansible playbooks and roles for networking services using Molecule, with Goss as the verifier in a Python virtual environment. It incorporates your prior queries (e.g., Molecule-Goss setup, playbook paths, deprecated `lint` setting) and addresses the unique challenges of networking automation.

#### Why Use Molecule for Networking Services?
Molecule is ideal for testing Ansible playbooks and roles because it:
- Automates the creation of test environments (e.g., virtualized network devices).
- Applies Ansible code and verifies outcomes with tools like Goss.
- Supports iterative development with commands like `molecule converge` and `molecule verify`.
- Integrates with CI/CD for continuous testing ([Molecule Documentation](https://ansible-molecule.readthedocs.io/en/latest/)).

Networking services, however, pose challenges:
- Network devices (e.g., Cisco IOS, Juniper JunOS) use specialized OSes, not general-purpose Linux/Windows.
- Traditional Molecule drivers (Podman, Vagrant) don’t natively support proprietary network OSes.
- Verification requires network-specific checks (e.g., VLAN status, routing tables).

Solutions include using **Linux-based network OSes** (e.g., Cumulus VX, FRR), **virtual appliances** (e.g., Arista vEOS), or **simulators** (e.g., GNS3, Cisco Modeling Labs).

#### Prerequisites
- **System**: Linux with Python 3.8+, Podman, `pip`, `venv`.
- **Tools**:
  - `ansible>=2.9`: For network automation modules (e.g., `ansible.netcommon`).
  - `molecule>=4.0`: For testing.
  - `molecule-goss`: For verification.
  - `podman`: Python library for Podman driver.
  - `ansible-lint`, `yamllint`: For linting.
  - `ansible.netcommon`: Collection for network automation (`ansible-galaxy collection install ansible.netcommon`).
- **Permissions**: User in the `podman` group (`sudo usermod -aG podman $USER`).
- **Network Simulators**: Access to Cumulus VX, FRR, Arista vEOS, or GNS3.

#### Step-by-Step Workflow

##### 1. Set Up Python Virtual Environment
```bash
python3 -m venv molecule-venv
source molecule-venv/bin/activate
python3 -m pip install --upgrade pip
python3 -m pip install ansible molecule molecule-goss podman ansible-lint yamllint
ansible-galaxy collection install ansible.netcommon
```
- Ensures a clean environment, as per your prior Molecule queries ([Installation - Molecule](https://ansible-molecule.readthedocs.io/en/latest/installation/)).

##### 2. Create Project Structure
```bash
mkdir ansible-networking
cd ansible-networking
mkdir playbooks roles
```
- `playbooks/`: For playbooks like `network_playbook.yml`.
- `roles/`: For roles like `network_config`.

##### 3. Initialize Molecule Scenario
For playbooks:
```bash
molecule init scenario -d podman --verifier-name goss
```
For roles:
```bash
cd roles
molecule init role -d podman --verifier-name goss network_config
cd ..
```
- Creates `molecule/default/` with `molecule.yml`, `converge.yml`, and `tests/`.

##### 4. Configure `molecule.yml`
Use a Linux-based network OS like Cumulus VX for testing:
```yaml
---
dependency:
  name: galaxy
driver:
  name: podman
platforms:
  - name: cumulus-vx
    image: cumulusnetworks/cumulus-vx:4.4.0
    privileged: true
    network_mode: bridge
    command: /sbin/init
    pre_build_image: true
provisioner:
  name: ansible
  playbooks:
    converge: ../playbooks/network_playbook.yml
  connection_options:
    ansible_connection: ansible.netcommon.network_cli
    ansible_network_os: cumulusnetworks.cumulus.cumulus
    ansible_user: cumulus
    ansible_password: CumulusLinux!
    ansible_become: yes
    ansible_become_method: sudo
  lint:
    name: ansible-lint
verifier:
  name: goss
  enabled: true
```
- **Platforms**: Cumulus VX is a Linux-based network OS, ideal for Podman ([Cumulus VX Documentation](https://docs.cumulusnetworks.com/cumulus-vx/)).
- **Connection Options**: Configures Ansible for network devices using `network_cli` and Cumulus-specific settings.
- **Playbook Path**: Sets `provisioner.playbooks.converge` to your playbook, as requested.
- **Linting**: Uses `provisioner.lint` with `ansible-lint`, addressing the deprecated `lint` key.
- **Goss**: Verifies configurations on Linux-based network OSes.

**Alternative Platforms**:
- **FRR**: Use `image: frrouting/frr` for routing protocols.
- **Arista vEOS**: Use Vagrant or Podman with vEOS images (requires license).
- **GNS3**: Use the `delegated` driver to integrate with GNS3 VMs.

##### 5. Create Playbook
`playbooks/network_playbook.yml`:
```yaml
---
- name: Configure Network Switch
  hosts: all
  become: true
  tasks:
    - name: Configure VLAN 10
      ansible.netcommon.cli_config:
        config: |
          vlan 10
            name TEST_VLAN
      register: result
    - name: Ensure OSPF is enabled
      ansible.netcommon.cli_config:
        config: |
          router ospf
            ospf router-id 1.1.1.1
            network 192.168.1.0/24 area 0
```
- Uses `ansible.netcommon.cli_config` to send CLI commands to the network device.

##### 6. Create Role (Optional)
For a role, edit `roles/network_config/tasks/main.yml`:
```yaml
---
- name: Configure VLAN 10
  ansible.netcommon.cli_config:
    config: |
      vlan 10
        name TEST_VLAN
- name: Enable OSPF
  ansible.netcommon.cli_config:
    config: |
      router ospf
        ospf router-id 1.1.1.1
        network 192.168.1.0/24 area 0
```
Update `playbooks/network_playbook.yml` to use the role:
```yaml
---
- name: Apply Network Role
  hosts: all
  become: true
  roles:
    - network_config
```

##### 7. Write Goss Tests
`molecule/default/tests/test_default.yml`:
```yaml
---
command:
  ip link show vlan10:
    exit-status: 0
    stdout:
      - "vlan10.*vlan.*id 10"
  ospfctl show ospf:
    exit-status: 0
    stdout:
      - "Router ID: 1.1.1.1"
file:
  /etc/frr/frr.conf:
    exists: true
    contains:
      - "router ospf"
      - "network 192.168.1.0/24 area 0"
```
- **Limitations**: Goss works on Linux-based network OSes. For proprietary devices, use `ansible.netcommon.cli_command` in a `verify.yml` playbook:
  ```yaml
  ---
  - name: Verify Network Config
    hosts: all
    tasks:
      - name: Check VLAN 10
        ansible.netcommon.cli_command:
          command: show vlan brief
        register: vlan_result
      - name: Assert VLAN exists
        ansible.builtin.assert:
          that:
            - "'VLAN 10' in vlan_result.stdout"
  ```

##### 8. Run Tests
```bash
molecule test
```
- **Commands**:
  - `molecule converge`: Apply playbook/role.
  - `molecule verify`: Run Goss tests.
  - `molecule login`: Debug container.
  - `molecule destroy`: Clean up.

##### 9. Configure `yamllint`
Create `.yamllint.yml` in the project root:
```yaml
---
extends: default
rules:
  line-length:
    max: 120
  indentation:
    spaces: 2
```
Run `yamllint .` manually or in CI/CD.

##### 10. Deactivate Virtual Environment
```bash
deactivate
```

#### Advanced Configurations
- **GNS3 Integration**:
  Use the `delegated` driver for GNS3:
  ```yaml
  driver:
    name: delegated
  platforms:
    - name: cisco-ios
      groups:
        - network
      provider:
        name: gns3
  ```
  Requires manual VM setup in GNS3 ([Molecule with GNS3](https://ansible.readthedocs.io/projects/molecule/usage/)).
- **NETCONF**:
  For devices supporting NETCONF:
  ```yaml
  provisioner:
    connection_options:
      ansible_connection: ansible.netcommon.netconf
      ansible_network_os: cisco.ios.ios
  ```
- **CI/CD**:
  ```yaml
  name: Molecule Test
  on: [push]
  jobs:
    test:
      runs-on: ubuntu-latest
      steps:
        - uses: actions/checkout@v3
        - uses: actions/setup-python@v4
          with:
            python-version: '3.10'
        - run: |
            python3 -m pip install ansible molecule molecule-goss podman ansible-lint yamllint
            ansible-galaxy collection install ansible.netcommon
        - run: molecule test
  ```

#### Troubleshooting
- **Network CLI Errors**: Ensure `ansible.netcommon` is installed and `ansible_network_os` matches the device.
- **Goss Limitations**: For non-Linux devices, use `verify.yml` with `cli_command`.
- **Podman Issues**: Verify `privileged: true` and `network_mode: bridge` for network functionality.
- **Linting**: Configure `.ansible-lint` to skip network-specific rules if needed.

#### Best Practices
- **Use Simulators**: Start with Cumulus VX or FRR for simplicity.
- **Modular Roles**: Develop reusable roles for common tasks (e.g., VLANs, BGP).
- **Automate**: Integrate with CI/CD for continuous testing.
- **Document**: Maintain clear documentation for network-specific settings ([Ansible Network Automation](https://docs.ansible.com/ansible/latest/network/index.html)).

#### Resources
- [Molecule Documentation](https://ansible-molecule.readthedocs.io/en/latest/)
- [Ansible Network Automation](https://docs.ansible.com/ansible/latest/network/index.html)
- [Cumulus VX with Ansible](https://docs.cumulusnetworks.com/cumulus-vx/)
- [Molecule-Goss GitHub](https://github.com/ansible-community/molecule-goss)
