class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.29.3"
    checksums = {
        "darwin_arm64" => "96c9c2eb45681632ade0bd1aa7a3cb762ef40eecc747363d18eb8369f5f6d0ee",
        "darwin_amd64" => "05b788b60b654eba3838660bb52c2e503d5033f16969fd149fb4939bf41177c1",
        "linux_arm64"  => "52f2df0c632631f0f1b29522d60558b8553ed70c959ba9bfee0cfb5b17f828ae",
        "linux_amd64"  => "3dfb8d2cae4109aca23c041677253373c999784190f2206e1d6a29ebe88a6bd6",
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
