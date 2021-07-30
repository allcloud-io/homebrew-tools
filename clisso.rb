# typed: false
# frozen_string_literal: true

class Clisso < Formula
  desc "Get temporary credentials for cloud providers from the command-line"
  homepage "https://github.com/allcloud-io/clisso"
  url "https://github.com/allcloud-io/clisso/archive/0.9.0.tar.gz"
  sha256 "438bf6adccd26a305bef8205c3b18e1375bfa9a25893a221412adb8e9f339890"
  version "0.9.0"

  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/allcloud-io/clisso/releases/download/0.9.0/clisso-darwin-amd64.zip"
    sha256 "8b88748e84a17949e48bfbb3d0f919f0e9c1a7b64a22012c785d0b101a136f2e"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/allcloud-io/clisso/releases/download/0.9.0/clisso-darwin-arm64.zip"
    sha256 "0d3eb0f706296995da8b9c0a82506e4af39c3026f0975a7af4f7823cfbb8a797"
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
