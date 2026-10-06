class Locally < Formula
  desc "Local Azure environment that runs entirely on your machine"
  homepage "https://locally.build/"
  version "2026.09.03"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://get.locally.build/v1/cli/#{version}/darwin/arm64"
      sha256 "6f6f05cbf8b182a382a6e720becbf0a776488bce148b04b5f69904f980aa9f22"
    end

    if Hardware::CPU.intel?
      url "https://get.locally.build/v1/cli/#{version}/darwin/amd64"
      sha256 "474377ae561ab87c532959f0974997a19dcf61b16d3af24e3e826f60c39afe43"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://get.locally.build/v1/cli/#{version}/linux/arm64"
      sha256 "9778336aabd1528a612ae93ce8067b8672465000514a0505b76dd312d93a6451"
    end

    if Hardware::CPU.intel?
      url "https://get.locally.build/v1/cli/#{version}/linux/amd64"
      sha256 "e05808626d1ebc1af9d77f6275487776540a5d451d60e6ba01e94f3526c10427"
    end
  end

  def install
    bin.install "locally"
  end

  test do
    system bin/"locally", "version"
  end
end
