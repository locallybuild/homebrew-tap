class Locally < Formula
  desc "Local Azure environment that runs entirely on your machine"
  homepage "https://locally.build/"
  version "2026.11.02"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://get.locally.build/v1/cli/#{version}/darwin/arm64"
      sha256 "97e92a2a492cc411768a90f96761a9f925a8d7872d738ddbb9d447fa57f4b0ec"
    end

    if Hardware::CPU.intel?
      url "https://get.locally.build/v1/cli/#{version}/darwin/amd64"
      sha256 "ea4d2c46b4eebf5a99392a43424513504b6ecdb61e51b5743564092f5c1bcaa6"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://get.locally.build/v1/cli/#{version}/linux/arm64"
      sha256 "35c2ccc031a09ec4e04441bfbf6683c387beae1a9befae76fb21f2d15cb43c16"
    end

    if Hardware::CPU.intel?
      url "https://get.locally.build/v1/cli/#{version}/linux/amd64"
      sha256 "1aa9c88aa9f8d53e3c3c401b69c1481dd4db3207b7e0ed37b5a88df92c5e7298"
    end
  end

  def install
    bin.install "locally"
  end

  test do
    system bin/"locally", "version"
  end
end
