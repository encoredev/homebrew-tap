class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.29.1-beta.5"
    checksums = {
        "darwin_arm64" => "4f7cf11ef87635430d4cf80bc3c582c59dcbcccae53811086fd6420796f47211",
        "darwin_amd64" => "ec07435328ab8e6fb8e4fc928cb21f61c366906fa82b8c56c14623cc1a8f0b7c",
        "linux_arm64"  => "ef4270d73f59cbab940f449084575c49ced0f67fcfd871b27b6240da95114be2",
        "linux_amd64"  => "71b0441511621043a18772eb02c0b27ff7574815d378b9ba0561e2b540b49046",
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

        bin.install_symlink libexec/"bin/encore-beta"


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "bash")
        (bash_completion/"encore-beta").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "zsh")
        (zsh_completion/"_encore-beta").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "fish")
        (fish_completion/"encore-beta.fish").write output
    end

    test do
        system "#{bin}/encore-beta", "check"
    end
end
