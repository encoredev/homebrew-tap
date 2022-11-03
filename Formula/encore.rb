class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.10.0"
    checksums = {
        "darwin_arm64" => "2fdac5ee996586b93548ecdcce57fa5a83db347b55d07000cf5d165e00ad4c01",
        "darwin_amd64" => "74dd0951f138333c35058ecb6edba4715f6cd4e9d60e44668e4227b0f2e29890",
        "linux_arm64"  => "a447f33d7e34d4c9046e82f52e5983243108339c5f58c980f2c0ce66ea669b7b",
        "linux_amd64"  => "a1cee3dde0b1f2ebafae629099d048d35c6683cae65f6ad7544279783b9302f1",
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
