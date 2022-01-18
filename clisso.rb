# typed: false
# frozen_string_literal: true

class Clisso < Formula
  desc "Get temporary credentials for cloud providers from the command-line"
  homepage "https://github.com/allcloud-io/clisso"
  url "https://github.com/allcloud-io/clisso/archive/0.9.3.tar.gz"
  sha256 "ffe53602b75baeedba1ef2ebb5febaf9c2b1fa9203ca1a480c0b67e069111fde"
  version "0.9.3"

  bottle do
    sha256 cellar: :any_skip_relocation, monterey: "bc04f928764297597ffae034c4d82a88df84186f10307e4bfdbb424a873c4766"
  end

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/allcloud-io/clisso/releases/download/0.9.3/clisso-darwin-amd64.zip"
    sha256 "a771fd4d8f659097552c090fb1cff0a19cd482b927984bf0e6f582745282fc46"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/allcloud-io/clisso/releases/download/0.9.3/clisso-darwin-arm64.zip"
    sha256 "7024d0ee086ffa294281882527e690f2620b18ba6903ab803195494c1456aef4"
  end

  def install
    if OS.mac? && Hardware::CPU.intel?
      bin.install "clisso-darwin-amd64" => "clisso"
    elsif OS.mac? && Hardware::CPU.arm?
      bin.install "clisso-darwin-arm64" => "clisso"
    else
      ENV["GOPATH"] = buildpath
      ENV.prepend_create_path "PATH", buildpath/"bin"
      dir = buildpath/"src/github.com/allcloud-io/clisso"
      dir.install buildpath.children - [buildpath/".brew_home"]
      cd dir do
        ENV["VERSION"] = version
        system "make", "-e", "native"
        bin.install "build/clisso" => "clisso"
      end
    end
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test clisso`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "#{bin}/clisso", "version"
  end
end
