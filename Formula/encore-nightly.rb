class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230424"
    checksums = {
        "darwin_arm64" => "91945a3a7d8e609601c2ab264af72bb7ac83b91fe26f94dd239135951d76aa04",
        "darwin_amd64" => "34f15439eb51843c0fc1a62ac7579fa42e1430c2270cced441d31a6d33c92c95",
        "linux_arm64"  => "1b54c4b9961c4c79fc8ef1b933a6ff66f722778a7387907859aef0e4d267b3d2",
        "linux_amd64"  => "5998678a5dc4a857917ffe18b6f0e01b9aa4eec52893986f3f23a14cb259e4e4",
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
