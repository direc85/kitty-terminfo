Name:           kitty-terminfo
Summary:        KiTTY terminal emulator terminfo file
Version:        0.28.1
Release:        1
Group:          Applications/System
BuildArch:      noarch
License:        GPLv3
URL:            https://github.com/direc85/kitty-terminfo
Source0:        %{name}-%{version}.tar.bz2

%description
Terminfo file for KiTTY terminal emulator.

%prep
%setup -q -n %{name}-%{version}

%install
install -D xterm-kitty %{buildroot}%{_datadir}/terminfo/x/xterm-kitty

%files
%defattr(-,root,root,-)
%{_datadir}/terminfo/x/xterm-kitty
