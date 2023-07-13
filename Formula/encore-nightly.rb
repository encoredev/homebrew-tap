class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230713"
    checksums = {
        "darwin_arm64" => "713cd18c73f94d9db21b50e027fbba6367f98ccf47078b9918206a720c2f7e3d",
        "darwin_amd64" => "467eef7d7eb006d0b49c4120d24e47f133c54a1a5d27acc02c821c9a9ca13474",
        "linux_arm64"  => "18d4bceaefb8dfe42afdd8f4882d9b0079440489e0b03aa60a2e030366aecd41",
        "linux_amd64"  => "afe63442e811b90ddfc668f4e7e00a93404e67425088989e7140c6ed2d8656ac",
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
