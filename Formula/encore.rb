class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.30.0"
    checksums = {
        "darwin_arm64" => "28df2dcddceac326f8870b9d2a5096ff12e89816c5cf02105784761b8b2f879a",
        "darwin_amd64" => "e3186478337be8226410ad42d6733e3a088a8d3aab9419e3e895cc0903db8a73",
        "linux_arm64"  => "84b822d06cada5d9052ac44f99b2e98ad56667878f85716ddf375980d7538e18",
        "linux_amd64"  => "42b9fa8d9fbf880761d2161d3baa43102a28723f0f2db771f931172d63c5162f",
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
