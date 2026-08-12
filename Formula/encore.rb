class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.58.0"
    checksums = {
        "darwin_arm64" => "8eff0a7a3dec3e63c5841f3a323ee7e19870e05bb98333e503a88a76638bc758",
        "darwin_amd64" => "62fb123d87c77d231dffeaf942c738388c5687e44fd54b3120db8f37cfbf5673",
        "linux_arm64"  => "0bd2a0ea8006393f9927d72630be05589da2cbaa6057fd19586851200febfce9",
        "linux_amd64"  => "999e1056d3c5f9535f78ca3e2a386ad25818d043bac4dc9b5509ec634cf1cf24",
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
