class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.29.0-beta.10"
    checksums = {
        "darwin_arm64" => "21fe712f120ee2513e9ab1e3d29b457f8f13c83498c4389c6dd636a97ca59450",
        "darwin_amd64" => "caba48f103b3dc8e8682f0fe00ff1ea63575881947a1153ad12b4a27af35f46d",
        "linux_arm64"  => "273ec7fe9303ec20961ee8212b45c30886c2d6a16b60c3c9b9f1a33970963915",
        "linux_amd64"  => "22611500f1fb0dabdfd624371611761cd109ca7134bad1e0f18083e198080cfb",
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
