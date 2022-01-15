%define debug_package %{nil}

%define mybuildnumber %{?build_number}%{?!build_number:1}

Name:           pautosurround
Version:        0.0.2
Release:        %{mybuildnumber}%{?dist}
Summary:        Companion for PulseAudio and PipeWire to automatically set outputs to multichannel when multichannel content is played.

License:        GPLv2+
URL:            https://github.com/Rudd-O/%{name}
Source0:        https://github.com/Rudd-O/%{name}/archive/{%version}.tar.gz#/%{name}-%{version}.tar.gz

BuildRequires:  make
BuildRequires:  python3-mypy
BuildRequires:  systemd-rpm-macros

Requires: python3-pulsectl
Requires: pulseaudio-daemon

%description
This program auto-switches your sound card to surround when surround content plays.

%prep
%setup -q

%build
# variables must be kept in sync with install
make DESTDIR=$RPM_BUILD_ROOT BINDIR=%{_bindir} UNITDIR=%{_userunitdir} PRESETDIR=%{_userpresetdir}

%check
make check

%install
rm -rf $RPM_BUILD_ROOT
# variables must be kept in sync with build
make install DESTDIR=$RPM_BUILD_ROOT BINDIR=%{_bindir} UNITDIR=%{_userunitdir} PRESETDIR=%{_userpresetdir}

%files
%attr(0755, root, root) %{_bindir}/%{name}
%config %attr(0644, root, root) %{_userunitdir}/%{name}.service
%config %attr(0644, root, root) %{_userpresetdir}/80-%{name}.preset
%doc README.md

%post
%systemd_user_post  %{name}.service

%changelog
* Tue Jan 11 2022 Manuel Amador (Rudd-O) <rudd-o@rudd-o.com>
- Initial release
