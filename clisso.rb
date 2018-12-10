class Clisso < Formula
  desc "Get temporary credentials for cloud providers from the command-line"
  homepage "https://github.com/allcloud-io/clisso"
  url "https://github.com/allcloud-io/clisso/archive/0.7.0.tar.gz"
  sha256 "6f2ba6d9e6247cdd71c6833b3b9c8e0947b7de1744cfbef6efeb69a26b4f7555"

  bottle do
    root_url "https://github.com/allcloud-io/clisso/releases/download/0.7.0"
    cellar :any_skip_relocation
    sha256 "5e896f09960815a15e077dac25c158f0a0c412bcf6e99e752913ee97511fcc31" => :mojave
  end

  depends_on "dep" => :build
  depends_on "go" => :build
  depends_on "make" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV.prepend_create_path "PATH", buildpath/"bin"
    dir = buildpath/"src/github.com/allcloud-io/clisso"
    dir.install buildpath.children - [buildpath/".brew_home"]
    cd dir do
      system "dep", "ensure", "-vendor-only"
      ENV["VERSION"] = version
      system "make", "-e"
      bin.install "clisso" => "clisso"
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
