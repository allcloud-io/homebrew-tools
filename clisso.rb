class Clisso < Formula
  desc "Get temporary credentials for cloud providers from the command-line"
  homepage "https://github.com/allcloud-io/clisso"
  url "https://github.com/allcloud-io/clisso/archive/0.5.0.tar.gz"
  sha256 "da819973003a6fa21bf2605a6a0113aaa58080d42b78b2f276910fcdbb5b1511"

  depends_on "make" => :build
  depends_on "go" => :build
  depends_on "dep" => :build

  bottle do
    root_url 'https://github.com/allcloud-jonathan/clisso/releases/download/' + version
    sha256 "e873ecc13c57da29b1edd793c4283ad675a20b8b28e5ff9cab1c853dd38eebde" => :high_sierra
  end

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
