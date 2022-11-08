# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Clisso < Formula
  desc ""
  homepage ""
  version "0.11.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/allcloud-io/clisso/releases/download/0.11.0/clisso_darwin_arm64.zip"
      sha256 "85081186f6337e30eef702c54e571fecdad300a9da37c2573cf35942a6365252"

      def install
        bin.install "clisso"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/allcloud-io/clisso/releases/download/0.11.0/clisso_darwin_amd64.zip"
      sha256 "5c43263361f2ec419150524632b2555c044d96e7bd7ffb898244e5f61dc9b41f"

      def install
        bin.install "clisso"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/allcloud-io/clisso/releases/download/0.11.0/clisso_linux_arm64.zip"
      sha256 "d0b64d71c976e453654921546e200fd76a6eb4210a033a65fc4718dc0920dcc7"

      def install
        bin.install "clisso"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/allcloud-io/clisso/releases/download/0.11.0/clisso_linux_amd64.zip"
      sha256 "7f75c1c6fae5646c9b73ff795e32f7e356ea7e9b5640fb40c27bcbe5cea58a63"

      def install
        bin.install "clisso"
      end
    end
  end
end
