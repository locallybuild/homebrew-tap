class Locally < Formula
  desc "Local Azure environment that runs entirely on your machine"
  homepage "https://locally.build/"
  version "2026.09.01"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://get.locally.build/v1/cli/#{version}/darwin/arm64"
      sha256 "1021ad071af47a73208c623e4dff3c4fcd0768b6fc09491783340b3b68be16b6"
    end

    if Hardware::CPU.intel?
      url "https://get.locally.build/v1/cli/#{version}/darwin/amd64"
      sha256 "e36f2faa8e226674299977dae9a1846916fd87ae6b626595537d346fc9c65dec"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://get.locally.build/v1/cli/#{version}/linux/arm64"
      sha256 "9174fc1632872d3a28b928aa0015990548aa18c7497454e4d4747d0ffa5964e6"
    end

    if Hardware::CPU.intel?
      url "https://get.locally.build/v1/cli/#{version}/linux/amd64"
      sha256 "a007eb0a56a3a23bb572b20e1dd90c4d7287998d36dbd7f8a9c24d2feaf7d326"
    end
  end

  def install
    bin.install "locally"
  end

  test do
    system bin/"locally", "version"
  end
end
