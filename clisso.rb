# typed: false
# frozen_string_literal: true

class Clisso < Formula
  desc "Get temporary credentials for cloud providers from the command-line"
  homepage "https://github.com/allcloud-io/clisso"
  url "https://github.com/allcloud-io/clisso/archive/0.9.1.tar.gz"
  sha256 "3bf4fb53a591e1654b04a6bf1f3d5162b799dd14553ecd1531e29f982eeaf129"
  version "0.9.1"

  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/allcloud-io/clisso/releases/download/0.9.1/clisso-darwin-amd64.zip"
    sha256 "5e4789005784b18b79db6769469ea698d2ae35d87cb3a8d45a6863e481f2409a"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/allcloud-io/clisso/releases/download/0.9.1/clisso-darwin-arm64.zip"
    sha256 "e783b5e25a3c8193cb07929fad38074ee5c93911f3cee6a65a78f73d3dd9fa4a"
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
