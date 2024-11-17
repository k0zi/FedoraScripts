# FedoraScripts

### reinstall_dotnet_mono.sh

Reinstalls the following mono packages
* mono-devel
* mono-complete
* mono-extras

Reinstalls dotnet 8.0, 9.0 runtime and SDK

Creates a link between /usr/share/dotnet/sdk/ /usr/lib64/dotnet/sdk

Removes empty workloadset directories in /usr/share/dotnet/sdk-manifests/
