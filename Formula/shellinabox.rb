class Shellinabox < Formula
  desc "Web-based terminal emulator using AJAX/Comet"
  homepage "https://github.com/abcyon/shellinabox"
  url "https://github.com/abcyon/shellinabox/archive/refs/tags/v2.20.1.tar.gz"
  sha256 "7286379d2b39f9e75e72cfa307ff279ff6173f0ca7059ae15c74ddb1e8ecd806"
  license "GPL-2.0-only"
  head "https://github.com/abcyon/shellinabox.git", branch: "master"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "openssl@3"

  def install
    openssl = Formula["openssl@3"]
    system "autoreconf", "-fiv"
    system "./configure",
           "CFLAGS=-D_DARWIN_C_SOURCE -Os -I#{openssl.opt_include}",
           "LDFLAGS=-L#{openssl.opt_lib}",
           "--disable-debug",
           "--disable-dependency-tracking",
           "--disable-silent-rules",
           "--disable-runtime-loading",
           "--prefix=#{prefix}",
           "--mandir=#{man}",
           "--sysconfdir=#{etc}"
    system "make"
    system "make", "install"
  end

  service do
    run [opt_sbin/"shellinaboxd", "--port=4200", "--no-beep"]
    keep_alive true
    log_path var/"log/shellinabox.log"
    error_log_path var/"log/shellinabox.log"
  end

  test do
    system "#{sbin}/shellinaboxd", "--help"
  end
end
