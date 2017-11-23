# Puppet Deployment Code for petclinic

This is an example of *one way* to automatically provision and deploy Petclinic.

## Prerequisites

## How to run (semi-manual)

* :exclamation: _This is a semi-manual way, i.e. you are triggering an automated deployment script manually._
* This is not how it would usually be done, but its good for testing purposes.
* Also, this is a very bare-bones Puppet code for demonstration use only.

### Step 1. Install Puppet Modules

This code depends on the module `puppetlabs-java`.

* Install the module first on the target server: `puppet module install puppetlabs-java`.
* :exclamation: Make a note of where the module gets installed.
* You can use `puppet module list` to understand this.

**Example:**

The output below shows the module installed to `/home/vagrant/.puppetlabs/etc/code/modules`. Note down this directory.

```
$ puppet module list

/home/vagrant/.puppetlabs/etc/code/modules
├── puppet-archive (v2.2.0)
├── puppetlabs-java (v2.2.0)
└── puppetlabs-stdlib (v4.22.0)
/opt/puppetlabs/puppet/modules (no modules installed)
```

### Step 2. Run Puppet Manifest
* Clone the repository, in the server where Petclinic will run.
`git clone http://github.com/agilityroots/deployment-automation`

* CD to the directory
* Run the Puppet manifest.

```
cd deployment-automation/petclinic-puppet
sudo puppet apply manifests/ --modulepath ./modules:/home/vagrant/.puppetlabs/etc/code/modules
```

## Notes and Troubleshooting

**Provide the right `modulepath`**

:exclamation: Make sure you provide the correct module-path:

```
./modules:[PATH WHERE JAVA MODULE WAS INSTALLED]
```

**Error: `artifactpath` should be set**

```
Error: Evaluation Error: Error while evaluating a Function Call, A fact 'artifactpath' should be set! at modules/springboot/manifests/init.pp:34:5 on node ubuntu
```

You need to set a fact `artifactpath` when calling Puppet.
