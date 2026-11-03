class Locally < Formula
  desc "Local Azure environment that runs entirely on your machine"
  homepage "https://locally.build/"
  version "2026.10.02"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://get.locally.build/v1/cli/#{version}/darwin/arm64"
      sha256 "db0ccf4786fd470a0d43961411a7120f66a2ba7b0213eb75a48aa1fb6c516660"
    end

    if Hardware::CPU.intel?
      url "https://get.locally.build/v1/cli/#{version}/darwin/amd64"
      sha256 "f20d42373dc1bf60ede4fc7524768b65aa304adadba0eb504edff8c60036a968"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://get.locally.build/v1/cli/#{version}/linux/arm64"
      sha256 "87771a4ef383fbe66f55ae5dd6ee193d027e3a473771fbcacc7bfd13217de919"
    end

    if Hardware::CPU.intel?
      url "https://get.locally.build/v1/cli/#{version}/linux/amd64"
      sha256 "2779881c313afd1e9644dc3250b5ca2e520bd9fd20ce17b24e860d42c3f820fc"
    end
  end

  def install
    bin.install "locally"
  end

  test do
    system bin/"locally", "version"
  end
end
