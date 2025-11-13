class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.51.7"
    checksums = {
        "darwin_arm64" => "9b1329f235d6025d5f532f3c76be393d72103b140592d907bf6cbf66030f367c",
        "darwin_amd64" => "893f5308612f354fb23b2ceb5d98c95eb91b51044ee7cdbbc6f5bb55963166b8",
        "linux_arm64"  => "b9586b304403e919dcbc84341b437b13b95dbf60686e634bbb3fd821d0eeb71d",
        "linux_amd64"  => "24d70652f877001ce594f5ff394f6add93ea0b11123a67bfb87a949f39ad10e1",
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
