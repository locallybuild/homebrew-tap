class Locally < Formula
  desc "Local Azure environment that runs entirely on your machine"
  homepage "https://locally.build/"
  version "2026.09.02"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://get.locally.build/v1/cli/#{version}/darwin/arm64"
      sha256 "db877758d1caace7c5efed5253366671795bb9685d187bc9249da5656491978c"
    end

    if Hardware::CPU.intel?
      url "https://get.locally.build/v1/cli/#{version}/darwin/amd64"
      sha256 "29700785001dbe370f0dcf0f9c4c8be3a834903435e84a759f0689d6ae545f59"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://get.locally.build/v1/cli/#{version}/linux/arm64"
      sha256 "8eef1e04134ab34289ab34ea69fecc1431a0db3ba8bdf09510415e9fc460e2e8"
    end

    if Hardware::CPU.intel?
      url "https://get.locally.build/v1/cli/#{version}/linux/amd64"
      sha256 "c635d27f396fcc2cc0040e7136959a413f9d748a83eda52b4403ba552cf4b92f"
    end
  end

  def install
    bin.install "locally"
  end

  test do
    system bin/"locally", "version"
  end
end
