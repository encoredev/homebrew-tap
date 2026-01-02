class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.53.4"
    checksums = {
        "darwin_arm64" => "eb1dcd05bee819f76f7a9977374dfbaa82daa37252e2054a197061db248fabf3",
        "darwin_amd64" => "2b433cbe11cef9722af718ae4d10daae306c3acd8b0ff087b3464af9123219c9",
        "linux_arm64"  => "9b088ea7d34de52e68d77b24f3bfc09127fa1674477df822a43e68afd193c7a7",
        "linux_amd64"  => "2d5db129981e905560743d3b7da4af1b27ff69c9a0c86202076951471a982e0e",
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
