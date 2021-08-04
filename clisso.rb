# typed: false
# frozen_string_literal: true

class Clisso < Formula
  desc "Get temporary credentials for cloud providers from the command-line"
  homepage "https://github.com/allcloud-io/clisso"
  url "https://github.com/allcloud-io/clisso/archive/0.9.2.tar.gz"
  sha256 "880de2be69bd7f37fb1cc9b17e23636a493d1ce29fb1e27cb9e9c1cfd949fcd9"
  version "0.9.2"

  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/allcloud-io/clisso/releases/download/0.9.2/clisso-darwin-amd64.zip"
    sha256 "7ce756b71c353ac7805a2a050899259188b404aa491dbd6b0b3565fffa1b8cc1"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/allcloud-io/clisso/releases/download/0.9.2/clisso-darwin-arm64.zip"
    sha256 "997e1c9da894ef8582af03d0c76092403f954c5b2d69edacf8174c599b72f7e6"
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
