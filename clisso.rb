# typed: false
# frozen_string_literal: true

class Clisso < Formula
  desc "Get temporary credentials for cloud providers from the command-line"
  homepage "https://github.com/allcloud-io/clisso"
  url "https://github.com/allcloud-io/clisso/archive/0.9.0.tar.gz"
  sha256 "63bf75325b24873053953fb43c7514f323970c23fac1415307cd26ef27a321ff"
  version "0.9.0"

  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/allcloud-io/clisso/releases/download/0.9.0/clisso-darwin-amd64.zip"
    sha256 "63bf75325b24873053953fb43c7514f323970c23fac1415307cd26ef27a321ff"
  end

  def install
    if OS.mac? && Hardware::CPU.intel?
      bin.install "clisso-darwin-amd64" => "clisso"
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
