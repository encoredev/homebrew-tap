class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.31.2-beta.4"
    checksums = {
        "darwin_arm64" => "bb209d1805e91d3e3d028c398522bd65ed449a76b40ad11691aac7be91f4e301",
        "darwin_amd64" => "fd5c5da371c6f8ba770b9402847bcbd3d52fcba71f315e4d066977fdd44657d0",
        "linux_arm64"  => "386aae714151f27f6a6689e9af13f91f05d8bb17481675bb6353c184e5f17f29",
        "linux_amd64"  => "8b7c7b9b67d76b47984f483a8b7d1041030a28179ced528680a0a35fbf6ae926",
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
