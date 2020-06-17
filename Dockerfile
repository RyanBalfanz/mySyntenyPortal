FROM ubuntu:18.04
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y && apt-get install -y \
perl python gcc g++ wget bzip2 git \
apache2 php php-common imagemagick php-imagick php-imagick \
zlib1g-dev libpng-dev make sudo automake build-essential \
pkg-config libgd-dev
RUN wget http://security.ubuntu.com/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1.1_amd64.deb
RUN dpkg -i libpng12-0_1.2.54-1ubuntu1.1_amd64.deb
RUN echo 'ServerName localhost' >> /etc/apache2/apache2.conf && echo "export VISIBLE=now" >> /etc/profile
RUN cpan Test::Regexp App::cpanminus Sort::Key::Natural Data::PowerSet JSON Clone Config::General \
Font::TTF::Font GD GD::Polyline List::MoreUtils Math::Bezier Math::Round Math::VecStat Parallel::ForkManager \
Params::Validate Readonly Regexp::Common SVG Set::IntSpan Statistics::Basic Text::Format


EXPOSE 80
ADD . /code/
WORKDIR /code

# build myCircos and install web files in temp filesystem
RUN ./install.pl build && ./install.pl install

# launch the web server
RUN service apache2 start
