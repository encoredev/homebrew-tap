class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.58.6"
    checksums = {
        "darwin_arm64" => "d753656373aa9c271f4a7441493cf5a1d3a92cf5d316fb9686dfd9ca357ef497",
        "darwin_amd64" => "f0400b53c80ad95f99c16e25e0da6115ce28a70e1d6958d5ebfb3925f328d4aa",
        "linux_arm64"  => "874cc002a7132600f12d51f749ec2f6e061b6859a9988e2cb252e9e8da3e0d25",
        "linux_amd64"  => "46add1a88eb02349e4ce51269fdade91c52e8fc044c972cc0ae40129a1eb91b2",
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
