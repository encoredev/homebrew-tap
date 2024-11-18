class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.44.1"
    checksums = {
        "darwin_arm64" => "3d5c5031011da6e93718fb6c07f1b7af0fd0587671e65df421c62dc25ab8fff9",
        "darwin_amd64" => "ae6109915a85420e93cc378e7edaf9f23b9b2c9d4353a6397f419e05e85faab9",
        "linux_arm64"  => "d1da98b42940d0df1cb85403be20be685ebd2ed845e4376b81ce9299d9ebf382",
        "linux_amd64"  => "dc9b06d37982468faef59cb2f437da0a9f57f11c20cb2f4896e79604fca99a61",
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
