class Locally < Formula
  desc "Local Azure environment that runs entirely on your machine"
  homepage "https://locally.build/"
  version "2026.10"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://get.locally.build/v1/cli/#{version}/darwin/arm64"
      sha256 "abb89ec8706fafaf81f95000e8b720f87c923e3323ad7f96c91f4dd9c0293b76"
    end

    if Hardware::CPU.intel?
      url "https://get.locally.build/v1/cli/#{version}/darwin/amd64"
      sha256 "5cb0fdce3a368660736101c187747e590429f7de36ffbfe282bfb6deca62c0dd"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://get.locally.build/v1/cli/#{version}/linux/arm64"
      sha256 "e2c87dde757c0b52a1961702f4c0a19cddc8d3a0b9fc21f86d16e980be57ff66"
    end

    if Hardware::CPU.intel?
      url "https://get.locally.build/v1/cli/#{version}/linux/amd64"
      sha256 "852d0f10947ea1bb80384d88d50ede059028ad50de94de03c6c00d2c30be09e8"
    end
  end

  def install
    bin.install "locally"
  end

  test do
    system bin/"locally", "version"
  end
end
