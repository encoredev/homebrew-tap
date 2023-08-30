class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.25.1"
    checksums = {
        "darwin_arm64" => "99aeea41140ababfdf1b659b4e4627c0e8d79855ca75b9378a70c80013afdc39",
        "darwin_amd64" => "0affea6d338efe37621cfc305420a488400c133b4865f2f3d56acae4dc6a092b",
        "linux_arm64"  => "9894cc319f3a63d1c53ae7467ee627c8d6d4d1581cb4a7070ae7bf59d434bdc2",
        "linux_amd64"  => "656cbfa330608284194b18eacff97abee3a80b3e7c0a84614d3ecc4c7e33241a",
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
