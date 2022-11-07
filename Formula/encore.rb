class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.10.2"
    checksums = {
        "darwin_arm64" => "691efe6e4511a3216f5a18a9ea3dcd5d8f9daaf46ff0127a833766c9503d5e44",
        "darwin_amd64" => "6dfcdbb6d5dcb3e873a551b4be8b1d716c99ca128ae7da8c4d4ccdd07ef9fa00",
        "linux_arm64"  => "652cf19803373d1598178da20e4d2719cfbc327f1bd54af995bea5c1c1ba7f58",
        "linux_amd64"  => "6272cf143f5d6cc58e20dd600c9a96ba2009ff970aff63c6766bbd59d0e00b15",
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
