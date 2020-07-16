class Sops < Formula
  desc "Editor of encrypted files"
  homepage "https://github.com/mozilla/sops"
  url "https://github.com/mozilla/sops/archive/v3.6.0.tar.gz"
  sha256 "fee1c27f14f9f45b5955627e301aafcc38973c9458b25f99ef241bdd0a3b082c"
  license "MPL-2.0"
  head "https://github.com/mozilla/sops.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "55e5624ed3a1c5ccd2113d663483e8c6fabbb45dede9b691f8921d698549e39e" => :catalina
    sha256 "7df3685379929174b605e1767b13a19af0db45c4d7f27bbf6d3b6ac905235258" => :mojave
    sha256 "67541150ddec0ae37ad7b7f4df4ecca8eb8814bf49708abe8cf1e94099f398bb" => :high_sierra
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-o", bin/"sops", "go.mozilla.org/sops/v3/cmd/sops"
    pkgshare.install "example.yaml"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sops --version")

    assert_match "Recovery failed because no master key was able to decrypt the file.",
      shell_output("#{bin}/sops #{pkgshare}/example.yaml 2>&1", 128)
  end
end
