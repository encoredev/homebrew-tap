class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.14.5"
    checksums = {
        "darwin_arm64" => "ee3ebcb2f2a2caa3d87af586ae85ce50a922195d5bbaaec6d958282241c86ead",
        "darwin_amd64" => "df90d42f3472f9971b8168ebe7f9b8bb04ade247344f8bf70c74fc3044bcd3b8",
        "linux_arm64"  => "817906ca3e8862bae5d11a9927bb6caa168baec91dbd03e1ea11602cf7e99f9f",
        "linux_amd64"  => "04725a240dfb122ec353b0746bf523d59312c4ee4b937773b2e3f76a8afbee4d",
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
