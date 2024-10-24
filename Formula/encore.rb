class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.42.3"
    checksums = {
        "darwin_arm64" => "5ac932c4e73846048395bf17deb823c2c5312fa87f0915471c8e639bde35f8d9",
        "darwin_amd64" => "6d82fecdf44c88524abc64ce7cdf23daf97caed625858f394500c588f591c57f",
        "linux_arm64"  => "988e9a666ba437b49090340a983c4f3d8bdbda63ae4cf3ebac582ede05be9fef",
        "linux_amd64"  => "22e6f65bebed8331d0b8b7a219a3ce7417a3f4b3e8595777699876670b833187",
    }

    arch = "arm64"
    platform = "darwin"
    on_intel do
        arch = "amd64"
    end
    on_linux do
        platform = "linux"
    end

    url "https://d2f391esomvqpi.cloudfront.net/encore-#{release_version}-#{platform}_#{arch}.tar.gz"
    version release_version
    sha256 checksums["#{platform}_#{arch}"]

    def install
        libexec.install Dir["*"]

        bin.install_symlink Dir[libexec/"bin/*"]


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
        (bash_completion/"encore").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
        (zsh_completion/"_encore").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
        (fish_completion/"encore.fish").write output
    end

    test do
        system "#{bin}/encore", "check"
    end
end
