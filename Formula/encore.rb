class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.38.4"
    checksums = {
        "darwin_arm64" => "76675d5c145dfaab8acda943b57dfafe5223fa2b389c3cfe29c568b1ed5bc570",
        "darwin_amd64" => "1c4abad0906d29fa549471e3529eb9059dd6fd6b97a9795cfb4bd45404cd24af",
        "linux_arm64"  => "90be4dd149f9c6bc247ced6ec528ce7a42a13e9c61d3639b24707279993b74f1",
        "linux_amd64"  => "bc6ce40a539602c1681c15b1b7a390b9ada169c9b7f4c4ec2b99c177007a08d6",
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
