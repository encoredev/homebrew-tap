class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.43.5"
    checksums = {
        "darwin_arm64" => "b5b5f8e8d4a221aad00aafb590cf3560dd7cd4541da853e77e2655fd98e52320",
        "darwin_amd64" => "d92a0fe69380f5eb137057e1099209ebd56dcace7f0931916d7b6cff6201e47b",
        "linux_arm64"  => "ebd4c5b3a208c4f8bd9f4b32589ebbbaaaa9542595346bd40c8b939c79c09ba9",
        "linux_amd64"  => "0eccbca71403de529779b596a3d4903904a599352956db38e89285c4e59061d2",
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
