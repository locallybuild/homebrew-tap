class Locally < Formula
  desc "Local Azure environment that runs entirely on your machine"
  homepage "https://locally.build/"
  version "2026.11.05"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://get.locally.build/v1/cli/#{version}/darwin/arm64"
      sha256 "7c85fe10d682b56d2fdb5007c2238de283f4c6674af05641391f90114261a13a"
    end

    if Hardware::CPU.intel?
      url "https://get.locally.build/v1/cli/#{version}/darwin/amd64"
      sha256 "a0d12705244220f9951731ed0dc922cde02f462616a2b593cad2625617430ee9"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://get.locally.build/v1/cli/#{version}/linux/arm64"
      sha256 "01284e0bbeab7d6df60d94fa4475ea92b33887edbdbc898969f27438ec684438"
    end

    if Hardware::CPU.intel?
      url "https://get.locally.build/v1/cli/#{version}/linux/amd64"
      sha256 "f6456a2a44d8ad108120ed6a22c8043d2847e63ec631985b2919d8e1a73ac995"
    end
  end

  def install
    bin.install "locally"
  end

  test do
    system bin/"locally", "version"
  end
end
