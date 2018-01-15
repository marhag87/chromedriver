Name:		       chromedriver
Version:	     2.35
Release:	     1%{?dist}
Summary:	     WebDriver for Google Chrome/Chromium

Group:		     Unspecified
License:	     BSD and LGPLv2+ and ASL 2.0 and IJG and MIT and GPLv2+ and ISC and OpenSSL and (MPLv1.1 or GPLv2 or LGPLv2)
URL:		       http://www.chromium.org/Home
Source0:	     https://chromedriver.storage.googleapis.com/%{version}/%{name}_linux64.zip#/%{name}-%{version}.zip

BuildRequires: unzip

# Don't build debug package
%define debug_package %{nil}

%description
WebDriver is an open source tool for automated testing of webapps across many
browsers. It provides capabilities for navigating to web pages, user input,
JavaScript execution, and more. ChromeDriver is a standalone server which
implements WebDriver's wire protocol for Chromium. It is being developed by
members of the Chromium and WebDriver teams.

%prep
%setup -q -c

%build

%install
install -p -d -m 0755 %{buildroot}%{_bindir}
cp * %{buildroot}%{_bindir}/

%files
%doc
%{_bindir}/chromedriver

%changelog
* Mon Jan 15 2018 Martin Hagstrom <marhag87@gmail.com> 2.35-1
- Update to 2.35
* Mon Jan 15 2018 Martin Hagstrom <marhag87@gmail.com> 2.34-1
- Initial release
