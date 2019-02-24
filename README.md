
The main idea is to put duplicate commands into scripts when building an image.

Running the script you need to specify the following keys:

`packer-build.sh -g group -s storageaccount -l location -t ubuntu1604.json`

Replace the group, storageaccount and specify the path to the template.
