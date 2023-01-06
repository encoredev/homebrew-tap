class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230106"
    checksums = {
        "darwin_arm64" => "6f4c7d54d2569b75bc7580f02561421ec92a05a6b6060da384182ce39ea42af5",
        "darwin_amd64" => "7dcd3b40409a978c381a76b541f64d8adf13efec700e6adff3ba79ab6c9ff4b0",
        "linux_arm64"  => "a232b74e8087e1a6cf265def0be5f40c0a693ecc0a7a477e62e21fd05c0e0c46",
        "linux_amd64"  => "616daf6f59ebf36e7b66af6d963f7c0588306107b3dd415d393cf10261159030",
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
