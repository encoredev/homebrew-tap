class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.45.2-beta.1"
    checksums = {
        "darwin_arm64" => "7b7e07c045dca7a91734beeaa3efad416feff81a8bc4ce39be24aa4ca29caf95",
        "darwin_amd64" => "0cb5eb8d07ccd385a8331e8a5d060fdf88b36abaf6c82d44dce994cdd677d44b",
        "linux_arm64"  => "d59d367d6e73e011eb48e14aa4daefb9aaa27e126bff74a4a737111c734d916a",
        "linux_amd64"  => "d2ebd1284dcbb5dc0714035213e4b8ff7ba9b2786e8c8723e11b65d889cc3d00",
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
