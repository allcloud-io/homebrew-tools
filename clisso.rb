class Clisso < Formula
  desc "Get temporary credentials for cloud providers from the command-line"
  homepage "https://github.com/allcloud-io/clisso"
  url "https://github.com/allcloud-io/clisso/archive/0.8.3.tar.gz"
  sha256 "32a425eed2e98c6586230864ffe15086fae7c4bbdb20d7f8ae6cebd692951fe8"

  bottle do
    root_url "https://github.com/allcloud-io/clisso/releases/download/0.8.3"
    cellar :any_skip_relocation
    sha256 "9b08734bb31d0cb5533724fcfb89ee13952a7dc93639be7c039cc79c94e04070" => :big_sur
    sha256 "9b08734bb31d0cb5533724fcfb89ee13952a7dc93639be7c039cc79c94e04070" => :catalina
    sha256 "9b08734bb31d0cb5533724fcfb89ee13952a7dc93639be7c039cc79c94e04070" => :high_sierra
  end

  depends_on "go" => :build
  depends_on "make" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV.prepend_create_path "PATH", buildpath/"bin"
    dir = buildpath/"src/github.com/allcloud-io/clisso"
    dir.install buildpath.children - [buildpath/".brew_home"]
    cd dir do
      ENV["VERSION"] = version
      system "make", "-e", "unsigned-darwin-amd64-zip"
      system "unzip assets/clisso-darwin-amd64.zip"
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
