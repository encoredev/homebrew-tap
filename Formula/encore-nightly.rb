class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230427"
    checksums = {
        "darwin_arm64" => "6b6886c43e860dab62fbad99c8dd12d029cc5cf6e861d279907b7fd723c06c16",
        "darwin_amd64" => "a412f12a4c676c00837c2401697dc79f7dc21590e93679917e54e26ad7623e12",
        "linux_arm64"  => "bdafdc980190344cdca8f6fd592ea3e2ed69428ed4f9f128153e5c749a78cf16",
        "linux_amd64"  => "18bec7b6b423ed751b38daa76117b9ad612f7e6bc3687e97087ddc8992f52613",
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
