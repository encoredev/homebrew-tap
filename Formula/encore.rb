class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.25.1"
    checksums = {
        "darwin_arm64" => "c18cb3288c40e1b0d2c1da70301f1140ab477e62320bc804569a134422e8949c",
        "darwin_amd64" => "15e6d8031d68866cbdd2c063d4a402ef39d158bb29b6061a1784c25af5efd398",
        "linux_arm64"  => "63dd9970de8d130365013766ae17ca9c432d643082451222a2ea23b0636a012c",
        "linux_amd64"  => "feaa97ab825982ca4af25ad6968b4e84539f9356d24ac1a6f95383d0abe93425",
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
