# typed: true
# frozen_string_literal: true

# This file was generated by Homebrew Releaser. DO NOT EDIT.
class Clisso < Formula
  desc "Get temporary credentials for cloud providers from the command line"
  homepage "https://github.com/allcloud-io/clisso"
  url "https://github.com/allcloud-io/clisso/archive/refs/tags/0.17.0.tar.gz"
  sha256 "75013c2b27e535e4006ebce85513ab74e81f21c888e06a6d67dbc3f1c761e15c"
  license "MPL-2.0"

  on_macos do
    on_intel do
      url "https://github.com/allcloud-io/clisso/releases/download/0.17.0/clisso-0.17.0-darwin-amd64.tar.gz"
      sha256 "4eaa5d3c914056f08dda082d285691470cc08b8f98c02a3013f4007d052200c6"
    end

    on_arm do
      url "https://github.com/allcloud-io/clisso/releases/download/0.17.0/clisso-0.17.0-darwin-arm64.tar.gz"
      sha256 "82711c9307fd59f4bc9b8c2e716a0e434384573217091664277f95ae8fc0ed5e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/allcloud-io/clisso/releases/download/0.17.0/clisso-0.17.0-linux-amd64.tar.gz"
      sha256 "cd8c3a6b19247dde888a46904a89f9abd55a25c22cdf68d265d953b9ca10d418"
    end

    on_arm do
      url "https://github.com/allcloud-io/clisso/releases/download/0.17.0/clisso-0.17.0-linux-arm64.tar.gz"
      sha256 "987f11924cb1be79021a1b9898d0acac75a377adba2d4ed5aa15ca269a9d7c10"
    end
  end

  def install
    bin.install "clisso"
  end
end
