class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.43.2"
    checksums = {
        "darwin_arm64" => "dabe34070f5e248235d25ebb8b862eea419d4fc68da9f976175d18ec1f13e59c",
        "darwin_amd64" => "1966010de0905dbcfb5e41605db1416cce511684168e60d32f341ff4932e63f0",
        "linux_arm64"  => "47a708a1150b952a69b4219ce86fa92bc184c84d63d965cc5a068a107a45f163",
        "linux_amd64"  => "b29dd8be706ea738e3932c0715af628f84523891a5000de18fca2769c229ef4c",
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
