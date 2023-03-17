class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.14.4"
    checksums = {
        "darwin_arm64" => "fd78608221c02a432a54e11be91531fb3c96be5875ad9d19789a35ab262cced8",
        "darwin_amd64" => "68936d49dba594d1369df61236787aed0bd6a3c04d3f95091bb265a58598ca7a",
        "linux_arm64"  => "f1ec887af4c3cad341284adf881213407ac9bbdf8676c4cce8e198a42422396c",
        "linux_amd64"  => "f33f7e2f288926e87fe6cf0b02d784ec6de1aa1f6b7e68de8e2a98ec35c82761",
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
