class Locally < Formula
  desc "Local Azure environment that runs entirely on your machine"
  homepage "https://locally.build/"
  version "2026.10.03"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://get.locally.build/v1/cli/#{version}/darwin/arm64"
      sha256 "798382e0f8b2d5fe4d1b8b28e472afbc767a38264e276694a20f0bb205e50e00"
    end

    if Hardware::CPU.intel?
      url "https://get.locally.build/v1/cli/#{version}/darwin/amd64"
      sha256 "9eeabb9cd7815443d3c57d3adab2cfe7f00ee0f7d8bc04089eba32ee6876c1eb"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://get.locally.build/v1/cli/#{version}/linux/arm64"
      sha256 "e49effb10ecaa3ed91114bf9325ab217139def65283b2a27e39bea5bb443299d"
    end

    if Hardware::CPU.intel?
      url "https://get.locally.build/v1/cli/#{version}/linux/amd64"
      sha256 "019c82b6b8f6cee5649ae3cac76a6598160549498309d407cf13b825b66a92d2"
    end
  end

  def install
    bin.install "locally"
  end

  test do
    system bin/"locally", "version"
  end
end
