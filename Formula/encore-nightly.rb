class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20231018"
    checksums = {
        "darwin_arm64" => "1446f9ad73860461d139664d86bc59274b07c06f6d22f94973a2d6efc9d25e6d",
        "darwin_amd64" => "898e64eecf3612a0ddf114f583b3740be92f75919bc9d0ce03fe98f384003aa4",
        "linux_arm64"  => "0a3cf633a5eef2ba853f4316941993f02dabf2d0b62741eab6092d1920647b90",
        "linux_amd64"  => "e19656c1078bdd473e8cb49cd308af69ce1b87a74828ab9344d0e055a8050667",
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
