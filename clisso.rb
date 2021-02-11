class Clisso < Formula
  desc "Get temporary credentials for cloud providers from the command-line"
  homepage "https://github.com/allcloud-io/clisso"
  url "https://github.com/allcloud-io/clisso/archive/0.8.0.tar.gz"
  sha256 "5dbbfef92fa08efec2281400a2a9f13cbc942a7e722f4503b52f095ccba013d0"

  bottle do
    root_url "https://github.com/allcloud-io/clisso/releases/download/0.8.0"
    cellar :any_skip_relocation
    sha256 "05b78b4b88e61d1ceb81455c2b9e7c7413453d7e41d456f74a03bee746d1cfad" => :big_sur
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
